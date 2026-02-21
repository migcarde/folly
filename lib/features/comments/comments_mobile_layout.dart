import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/extensions/scroll_controller_extensions.dart';
import 'package:folly/features/comments/comments_notifier.dart';
import 'package:folly/features/comments/widgets/comments_empty.dart';
import 'package:folly/features/comments/widgets/comments_list.dart';
import 'package:folly/features/story_card/story_card_notifier.dart';
import 'package:folly/widgets/text_field/base_text_field.dart';
import 'package:folly/widgets/text_field/text_field_type.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CommentsMobileLayout extends ConsumerStatefulWidget {
  const CommentsMobileLayout({
    super.key,
    required this.storyId,
    required this.userStoryId,
    this.isExpanded = false,
  });

  final String storyId;
  final String userStoryId;
  final bool isExpanded;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommentsMobileLayoutState();
}

class _CommentsMobileLayoutState extends ConsumerState<CommentsMobileLayout> {
  final _scrollController = ScrollController();
  final _commentTextFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      if (currentScroll >= maxScroll - 200.0) {
        ref.read(commentsNotifierProvider(widget.storyId).notifier).nextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final state = ref.watch(commentsNotifierProvider(widget.storyId));

    return state.when(
      data: (data) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (data.comments.isEmpty) ...[
            widget.isExpanded
                ? Expanded(child: CommentsEmpty())
                : CommentsEmpty(),
          ] else
            widget.isExpanded
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimens.m,
                      ),
                      child: CommentsList(
                        scrollController: _scrollController,
                        comments: data.comments,
                        isLast: data.isLast,
                        onTapReply: (comment) => ref
                            .read(
                              commentsNotifierProvider(widget.storyId).notifier,
                            )
                            .setCommentToReply(comment),
                      ),
                    ),
                  )
                : Flexible(
                    child: CommentsList(
                      scrollController: _scrollController,
                      comments: data.comments,
                      isLast: data.isLast,
                      onTapReply: (comment) => ref
                          .read(
                            commentsNotifierProvider(widget.storyId).notifier,
                          )
                          .setCommentToReply(comment),
                    ),
                  ),
          Align(
            alignment: Alignment.centerRight,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              child: state.value?.commentToReply != null
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.s,
                        vertical: AppDimens.xs,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(
                          AppDimens.circularRadius,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              l10n.replying_to(
                                state.value?.commentToReply?.user.username ??
                                    '',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: AppDimens.s),
                            child: GestureDetector(
                              onTap: () => ref
                                  .read(
                                    commentsNotifierProvider(
                                      widget.storyId,
                                    ).notifier,
                                  )
                                  .clearCommentToReply(),
                              child: Icon(
                                PhosphorIcons.x(),
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppDimens.xs),
            child: BaseTextField(
              controller: _commentTextFieldController,
              hint: l10n.write_a_comment,
              textType: BaseTextFieldType.inlineTextArea,
              icon: PhosphorIcons.paperPlaneTilt(),
              type: TextFieldType.alternative,
              isLoading: data.commentIsSending,
              maxLines: 3,
              onTapIcon: () async {
                if (_commentTextFieldController.text.isNotEmpty) {
                  await ref
                      .read(commentsNotifierProvider(widget.storyId).notifier)
                      .createComment(
                        text: _commentTextFieldController.text,
                        receiverUserId: widget.userStoryId,
                      );

                  _commentTextFieldController.clear();
                  ref
                      .read(storyCardNotifierProvider(widget.storyId).notifier)
                      .addCommentCount();
                  _scrollController.scrollToTop();
                }
              },
            ),
          ),
        ],
      ),
      error: (e, strackTrace) => const SizedBox(),
      loading: () => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator()],
      ),
    );
  }
}

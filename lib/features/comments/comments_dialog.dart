import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/comments/comments_notifier.dart';
import 'package:folly/comment_tile/comment_tile.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/widgets/text_field/base_text_field.dart';
import 'package:folly/widgets/text_field/text_field_type.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CommentsDialog extends ConsumerStatefulWidget {
  const CommentsDialog({super.key, required this.storyId});

  final String storyId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentsDialogState();
}

class _CommentsDialogState extends ConsumerState<CommentsDialog> {
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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.screenPadding),
        child: state.when(
          data: (data) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (data.comments.isEmpty) ...[
                Icon(
                  PhosphorIcons.chatCircleSlash(),
                  size: AppDimens.xl,
                  color: theme.colorScheme.outline,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppDimens.m),
                  child: Text(
                    l10n.no_yet(l10n.comments),
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ),
              ] else
                Flexible(
                  child: ListView.separated(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index == data.comments.length && !data.isLast) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final comment = data.comments[index];

                      return Column(
                        children: [
                          CommentTile(
                            commentId: comment.id,
                            name: comment.user.username,
                            photoPath: comment.user.photoPath,
                            comment: comment.text,
                            onTapProfile: () => context.push(
                              Paths.userProfile.route,
                              extra: comment.user,
                            ),
                            onTapReply: () => ref
                                .read(
                                  commentsNotifierProvider(
                                    widget.storyId,
                                  ).notifier,
                                )
                                .setCommentToReply(comment),
                          ),
                          if (comment.replies.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: AppDimens.m,
                                left: AppDimens.l,
                              ),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => CommentTile(
                                  commentId: comment.replies[index].id,
                                  name: comment.replies[index].user.username,
                                  photoPath:
                                      comment.replies[index].user.photoPath,
                                  comment: comment.replies[index].text,
                                  onTapProfile: () => context.push(
                                    Paths.userProfile.route,
                                    extra: comment.replies[index].user,
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: AppDimens.s),
                                itemCount: comment.replies.length,
                              ),
                            ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: AppDimens.m),
                    itemCount: data.comments.length,
                  ),
                ),
              const SizedBox(height: AppDimens.m),
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
                                    state
                                            .value
                                            ?.commentToReply
                                            ?.user
                                            .username ??
                                        '',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: AppDimens.s,
                                ),
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
                  maxLines: 3,
                  onTapIcon: () {
                    if (_commentTextFieldController.text.isNotEmpty) {
                      ref
                          .read(
                            commentsNotifierProvider(widget.storyId).notifier,
                          )
                          .createComment(
                            text: _commentTextFieldController.text,
                          );

                      _commentTextFieldController.clear();
                    }
                  },
                ),
              ),
            ],
          ),
          error: (e, strackTrace) => const SizedBox(),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

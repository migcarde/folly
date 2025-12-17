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

                      return CommentTile(
                        commentId: comment.id,
                        name: comment.user.name,
                        photoPath: comment.user.photoPath,
                        comment: comment.text,
                        isReply: comment.parentCommentId != null,
                        onTapProfile: () => context.push(
                          Paths.userProfile.route,
                          extra: comment.user,
                        ),
                        onTapReply: () {
                          // TODO: Update comment textfield to reference this comment and update textfield to add reply indicator
                        },
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: AppDimens.m),
                    itemCount: data.comments.length,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.m),
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

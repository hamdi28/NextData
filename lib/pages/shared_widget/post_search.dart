import 'package:next_data/core/models/post_model.dart';
import 'package:next_data/pages/shared_widget/debouncer_widget.dart';

class PostSearch {
  final List<Post> posts;
  final Debouncer debouncer;

  PostSearch({required this.posts, required this.debouncer});

  /// Searches for posts matching the query.
  /// The search is debounced to limit the frequency of the search action.
  /// The `onResult` callback is called with the search results.
  void search(String query, Function(List<Post>) onResult) {
    debouncer.run(() {
      final results = posts
          .where((post) =>
          post.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      onResult(results);
    });
  }
}

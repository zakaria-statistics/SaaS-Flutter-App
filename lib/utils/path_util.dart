import 'dart:html';

void updateUrl(String url) {
  window.history.pushState({}, '', url);
}
import 'package:equatable/equatable.dart';

abstract class PalindromeEvent extends Equatable {
  const PalindromeEvent();

  @override
  List<Object> get props => [];
}

class CheckPalindrome extends PalindromeEvent {
  final String text;
  const CheckPalindrome(this.text);

  @override
  List<Object> get props => [text];
}

class ResetPalindrome extends PalindromeEvent {
  const ResetPalindrome();
}

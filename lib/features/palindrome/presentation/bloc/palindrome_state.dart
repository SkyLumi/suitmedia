import 'package:equatable/equatable.dart';

abstract class PalindromeState extends Equatable {
  const PalindromeState();

  @override
  List<Object> get props => [];
}

class PalindromeInitial extends PalindromeState {
  const PalindromeInitial();
}

class PalindromeLoading extends PalindromeState {
  const PalindromeLoading();
}

class PalindromeDone extends PalindromeState {
  final bool isPalindrome;
  final String originalText;

  const PalindromeDone({
    required this.isPalindrome, 
    required this.originalText
  });

  @override
  List<Object> get props => [isPalindrome, originalText];
}

class PalindromeError extends PalindromeState {
  final String message;

  const PalindromeError(this.message);

  @override
  List<Object> get props => [message];
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'palindrome_event.dart';
import 'palindrome_state.dart';

class PalindromeBloc extends Bloc<PalindromeEvent, PalindromeState> {
  PalindromeBloc() : super(const PalindromeInitial()) {
    on<CheckPalindrome>(_onCheckPalindrome);
    on<ResetPalindrome>(_onResetPalindrome);
  }

  void _onCheckPalindrome(CheckPalindrome event, Emitter<PalindromeState> emit) async {
    emit(const PalindromeLoading());
    try {
      if (event.text.isEmpty) {
        emit(const PalindromeError("Isi textbox palindrome nya!"));
        return;
      }
      bool result = _isPalindrome(event.text);
      emit(PalindromeDone(
        isPalindrome: result,
        originalText: event.text,
      ));
    } catch (e) {
      emit(PalindromeError(e.toString()));
    }
  }
  
  void _onResetPalindrome(ResetPalindrome event, Emitter<PalindromeState> emit) {
    emit(const PalindromeInitial());
  }
  bool _isPalindrome(String text) {
    if (text.isEmpty) return false;
    String cleanText = text
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '') 
        .toLowerCase();
    String reverseText = cleanText.split('').reversed.join('');
    return cleanText == reverseText;
  }
}

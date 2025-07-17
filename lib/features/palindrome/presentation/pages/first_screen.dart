import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia/features/palindrome/presentation/bloc/palindrome_bloc.dart';
import 'package:suitmedia/features/palindrome/presentation/bloc/palindrome_event.dart';
import 'package:suitmedia/features/palindrome/presentation/bloc/palindrome_state.dart';
import 'package:suitmedia/features/homepage/presentation/pages/second_screen.dart';
import 'package:suitmedia/injection_container.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _palindromeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _palindromeController.dispose();
    super.dispose();
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PalindromeBloc>(
      create: (context) => sl<PalindromeBloc>(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Image(
                    image: AssetImage("assets/images/ic_photo.png"),
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 64),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        color: const Color(0xFF686777).withValues(alpha: 0.4),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _palindromeController,
                    decoration: InputDecoration(
                      hintText: 'Palindrome',
                      hintStyle: TextStyle(
                        color: const Color(0xFF686777).withValues(alpha: 0.4),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    ),
                  ),
                  const SizedBox(height: 48),
                  BlocConsumer<PalindromeBloc, PalindromeState>(
                    listener: (context, state) {
                      if (state is PalindromeDone) {
                        String message = state.isPalindrome ? "Ini Palindrome" : "Bukan Palindrome";
                        _showDialog("Result", message);
                      } 
                      else if (state is PalindromeError) {
                        _showDialog("Error", state.message);
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: state is PalindromeLoading 
                            ? null 
                            : () {
                                context.read<PalindromeBloc>().add(
                                  CheckPalindrome(_palindromeController.text)
                                );
                              },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2B637B),
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          child: state is PalindromeLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text('CHECK'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        String name = _nameController.text;
                        if (name.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SecondScreen(userName: name),
                            ),
                          );
                        } 
                        else {
                          _showDialog("masukkin nama dulu", "gabole kosong");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2B637B),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      child: const Text('NEXT'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// ignore_for_file: unused_element, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasteclip/core/auth/provider/auth_provider.dart';

class FirstScreen extends ConsumerStatefulWidget {
  const FirstScreen({super.key});

  @override
  FirstScreenState createState() => FirstScreenState();
}

class FirstScreenState extends ConsumerState<FirstScreen> {
  late final profileState = ref.read(authNotifierProvider.notifier);

  bool _isLoading = false;

  void _showLoaderAndNavigate() {
    setState(() {
      _isLoading = true;
    });

    // Future.delayed(const Duration(seconds: 3), () {
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context) => const Role()));
    // });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(authNotifierProvider.notifier);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () async {
              ref.read(authNotifierProvider.notifier).signOut();
            },
            child: const Text("Logout",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        // body: Stack(
        //   children: [
        //     Center(
        //       child: AppButton(
        //         onPressed: _showLoaderAndNavigate,
        //         text: 'Google',
        //       ),
        //     ),
        //     if (_isLoading)
        //       Container(
        //         color: Colors.black.withOpacity(0.8),
        //         child: const Center(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               SizedBox(height: 20),
        //               Text(
        //                 'Loading...',
        //                 style: TextStyle(color: Colors.white, fontSize: 18),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //   ],
        // ),
      ),
    );
  }
}

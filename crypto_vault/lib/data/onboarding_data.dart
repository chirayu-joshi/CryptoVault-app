import 'package:crypto_vault/models/onboarding_slide_model.dart';

const SLIDES = const [
  OnboardingSlideModel(
    imageUrl: 'assets/images/pillars.png',
    title: '3 Pillars of CryptoVault',
    description:
        'Privacy, Security and Simplicity are the 3 pillars of CryptoVault.',
  ),
  OnboardingSlideModel(
    imageUrl: 'assets/images/illustration_security.png',
    title: 'Generate and Store Passwords',
    description:
        'Generate strong passwords using modern cryptography algorithms, and store them securely.',
  ),
  OnboardingSlideModel(
    imageUrl: 'assets/images/illustration_cloud.png',
    title: 'Backup Data on Cloud',
    description:
        'With just some few easy steps, remove the risk of password loss or password leak.',
  ),
  OnboardingSlideModel(
    imageUrl: 'assets/images/illustration_e2ee.png',
    title: 'End to End Encryption',
    description:
        'Messages and File transfers are end-to-end encrypted, which eliminates the risk of tracking.',
  ),
];

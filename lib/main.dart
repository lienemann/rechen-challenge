import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MathChallengeApp());
}

enum Difficulty { easy, medium, hard }

enum PlayerMode { single, twoPlayer }

enum Operation { addition, subtraction, multiplication, division, mixed }

enum Language { english, german, french }

class AppLocalizations {
  final Language language;

  AppLocalizations(this.language);

  static Language _getSystemLanguage() {
    final systemLocale = ui.PlatformDispatcher.instance.locale.languageCode;
    switch (systemLocale) {
      case 'de':
        return Language.german;
      case 'fr':
        return Language.french;
      default:
        return Language.english;
    }
  }

  static Language get systemLanguage => _getSystemLanguage();

  String get appTitle {
    switch (language) {
      case Language.english:
        return 'Math Challenge';
      case Language.german:
        return 'Mathe-Herausforderung';
      case Language.french:
        return 'Défi Mathématique';
    }
  }

  String get chooseOperation {
    switch (language) {
      case Language.english:
        return 'Choose your operation!';
      case Language.german:
        return 'Wähle deine Operation!';
      case Language.french:
        return 'Choisissez votre opération!';
    }
  }

  String get selectOperation {
    switch (language) {
      case Language.english:
        return 'Select Operation:';
      case Language.german:
        return 'Operation wählen:';
      case Language.french:
        return 'Sélectionner l\'opération:';
    }
  }

  String get difficulty {
    switch (language) {
      case Language.english:
        return 'Difficulty';
      case Language.german:
        return 'Schwierigkeit';
      case Language.french:
        return 'Difficulté';
    }
  }

  String get easy {
    switch (language) {
      case Language.english:
        return 'Easy';
      case Language.german:
        return 'Einfach';
      case Language.french:
        return 'Facile';
    }
  }

  String get medium {
    switch (language) {
      case Language.english:
        return 'Medium';
      case Language.german:
        return 'Mittel';
      case Language.french:
        return 'Moyen';
    }
  }

  String get hard {
    switch (language) {
      case Language.english:
        return 'Hard';
      case Language.german:
        return 'Schwer';
      case Language.french:
        return 'Difficile';
    }
  }

  String get playerMode {
    switch (language) {
      case Language.english:
        return 'Player Mode';
      case Language.german:
        return 'Spielermodus';
      case Language.french:
        return 'Mode Joueur';
    }
  }

  String get single {
    switch (language) {
      case Language.english:
        return 'Single';
      case Language.german:
        return 'Einzel';
      case Language.french:
        return 'Solo';
    }
  }

  String get twoPlayers {
    switch (language) {
      case Language.english:
        return '2 Players';
      case Language.german:
        return '2 Spieler';
      case Language.french:
        return '2 Joueurs';
    }
  }

  String get rotateButtons {
    switch (language) {
      case Language.english:
        return 'Rotate Buttons';
      case Language.german:
        return 'Tasten drehen';
      case Language.french:
        return 'Faire pivoter';
    }
  }

  String get soundEffects {
    switch (language) {
      case Language.english:
        return 'Sound Effects';
      case Language.german:
        return 'Soundeffekte';
      case Language.french:
        return 'Effets sonores';
    }
  }

  String get languageLabel {
    switch (language) {
      case Language.english:
        return 'Language';
      case Language.german:
        return 'Sprache';
      case Language.french:
        return 'Langue';
    }
  }

  String get add {
    switch (language) {
      case Language.english:
        return 'Add';
      case Language.german:
        return 'Plus';
      case Language.french:
        return 'Plus';
    }
  }

  String get subtract {
    switch (language) {
      case Language.english:
        return 'Subtract';
      case Language.german:
        return 'Minus';
      case Language.french:
        return 'Moins';
    }
  }

  String get multiply {
    switch (language) {
      case Language.english:
        return 'Multiply';
      case Language.german:
        return 'Mal';
      case Language.french:
        return 'Multiplier';
    }
  }

  String get divide {
    switch (language) {
      case Language.english:
        return 'Divide';
      case Language.german:
        return 'Geteilt';
      case Language.french:
        return 'Diviser';
    }
  }

  String get mixed {
    switch (language) {
      case Language.english:
        return 'Mixed';
      case Language.german:
        return 'Gemischt';
      case Language.french:
        return 'Mixte';
    }
  }

  String get correct {
    switch (language) {
      case Language.english:
        return 'Correct! 🎉';
      case Language.german:
        return 'Richtig! 🎉';
      case Language.french:
        return 'Correct! 🎉';
    }
  }

  String tryAgain(int answer) {
    switch (language) {
      case Language.english:
        return 'Try again! The answer was $answer';
      case Language.german:
        return 'Versuch es nochmal! Die Antwort war $answer';
      case Language.french:
        return 'Réessayez! La réponse était $answer';
    }
  }

  String timeUp(int answer) {
    switch (language) {
      case Language.english:
        return 'Time\'s up! Answer was $answer';
      case Language.german:
        return 'Zeit abgelaufen! Antwort war $answer';
      case Language.french:
        return 'Temps écoulé! La réponse était $answer';
    }
  }

  String playerGotItRight(int player) {
    switch (language) {
      case Language.english:
        return 'Player $player got it right! 🎉';
      case Language.german:
        return 'Spieler $player hat es richtig! 🎉';
      case Language.french:
        return 'Joueur $player a trouvé! 🎉';
    }
  }

  String playerTried(int player, int answer) {
    switch (language) {
      case Language.english:
        return 'Player $player tried! Answer was $answer';
      case Language.german:
        return 'Spieler $player hat es versucht! Antwort war $answer';
      case Language.french:
        return 'Joueur $player a essayé! La réponse était $answer';
    }
  }

  String get gameComplete {
    switch (language) {
      case Language.english:
        return 'Game Complete!';
      case Language.german:
        return 'Spiel beendet!';
      case Language.french:
        return 'Jeu terminé!';
    }
  }

  String get player1Wins {
    switch (language) {
      case Language.english:
        return 'Player 1 Wins! 🎉';
      case Language.german:
        return 'Spieler 1 gewinnt! 🎉';
      case Language.french:
        return 'Joueur 1 gagne! 🎉';
    }
  }

  String get player2Wins {
    switch (language) {
      case Language.english:
        return 'Player 2 Wins! 🎉';
      case Language.german:
        return 'Spieler 2 gewinnt! 🎉';
      case Language.french:
        return 'Joueur 2 gagne! 🎉';
    }
  }

  String get tie {
    switch (language) {
      case Language.english:
        return 'It\'s a Tie! 🤝';
      case Language.german:
        return 'Unentschieden! 🤝';
      case Language.french:
        return 'Égalité! 🤝';
    }
  }

  String get playAgain {
    switch (language) {
      case Language.english:
        return 'PLAY AGAIN';
      case Language.german:
        return 'NOCHMAL SPIELEN';
      case Language.french:
        return 'REJOUER';
    }
  }

  String roundOf(int current, int total) {
    switch (language) {
      case Language.english:
        return 'Round $current/$total';
      case Language.german:
        return 'Runde $current/$total';
      case Language.french:
        return 'Tour $current/$total';
    }
  }

  String score(int score) {
    switch (language) {
      case Language.english:
        return 'Score: $score';
      case Language.german:
        return 'Punkte: $score';
      case Language.french:
        return 'Score: $score';
    }
  }

  String singlePlayerResult(int score, int total, String operationType) {
    switch (language) {
      case Language.english:
        return 'You got $score out of $total $operationType problems correct';
      case Language.german:
        return 'Du hast $score von $total $operationType-Aufgaben richtig gelöst';
      case Language.french:
        return 'Vous avez résolu $score problèmes $operationType sur $total correctement';
    }
  }

  String getOperationName(Operation operation) {
    switch (operation) {
      case Operation.addition:
        switch (language) {
          case Language.english: return 'addition';
          case Language.german: return 'Addition';
          case Language.french: return 'addition';
        }
      case Operation.subtraction:
        switch (language) {
          case Language.english: return 'subtraction';
          case Language.german: return 'Subtraktion';
          case Language.french: return 'soustraction';
        }
      case Operation.multiplication:
        switch (language) {
          case Language.english: return 'multiplication';
          case Language.german: return 'Multiplikation';
          case Language.french: return 'multiplication';
        }
      case Operation.division:
        switch (language) {
          case Language.english: return 'division';
          case Language.german: return 'Division';
          case Language.french: return 'division';
        }
      case Operation.mixed:
        switch (language) {
          case Language.english: return 'mixed math';
          case Language.german: return 'gemischte Mathematik';
          case Language.french: return 'mathématiques mixtes';
        }
    }
  }
}

class GameSettings {
  final Difficulty difficulty;
  final PlayerMode playerMode;
  final bool rotateButtons;
  final Operation operation;
  final bool soundEnabled;

  GameSettings({
    required this.difficulty, 
    required this.playerMode,
    required this.operation,
    this.rotateButtons = false,
    this.soundEnabled = true,
  });
}

class GameResult {
  final int player1Score;
  final int player2Score;
  final int totalRounds;
  final PlayerMode playerMode;
  final Operation operation;

  GameResult({
    required this.player1Score,
    required this.player2Score,
    required this.totalRounds,
    required this.playerMode,
    required this.operation,
  });
}

class MathChallengeApp extends StatelessWidget {
  const MathChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Comic Sans MS',
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Difficulty selectedDifficulty = Difficulty.medium;
  PlayerMode selectedPlayerMode = PlayerMode.single;
  bool rotateButtons = false;
  bool soundEnabled = true;
  Language selectedLanguage = AppLocalizations.systemLanguage;
  AppLocalizations? localizations;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final languageIndex = prefs.getInt('language') ?? selectedLanguage.index;
    setState(() {
      selectedLanguage = Language.values[languageIndex];
      localizations = AppLocalizations(selectedLanguage);
    });
  }

  void _saveLanguage(Language language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('language', language.index);
    setState(() {
      selectedLanguage = language;
      localizations = AppLocalizations(selectedLanguage);
    });
  }


  @override
  Widget build(BuildContext context) {
    // Ensure localizations is initialized
    final loc = localizations ?? AppLocalizations(selectedLanguage);
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue, Colors.blue, Colors.indigo],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calculate,
                  size: 120,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                Text(
                  loc.appTitle,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  loc.chooseOperation,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),

                // Difficulty Selection
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        loc.difficulty,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDifficultyButton(Difficulty.easy, loc.easy),
                          _buildDifficultyButton(Difficulty.medium, loc.medium),
                          _buildDifficultyButton(Difficulty.hard, loc.hard),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Player Mode Selection
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        loc.playerMode,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPlayerModeButton(PlayerMode.single, loc.single),
                          _buildPlayerModeButton(PlayerMode.twoPlayer, loc.twoPlayers),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Settings Row
                Row(
                  children: [
                    // Button Rotation Setting
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(left: 20, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Text(
                              loc.rotateButtons,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Switch(
                              value: rotateButtons,
                              onChanged: (value) {
                                setState(() {
                                  rotateButtons = value;
                                });
                              },
                              activeColor: Colors.orange,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.white.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Sound Setting
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Text(
                              loc.soundEffects,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Switch(
                              value: soundEnabled,
                              onChanged: (value) {
                                setState(() {
                                  soundEnabled = value;
                                });
                              },
                              activeColor: Colors.orange,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.white.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Language Setting
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(left: 5, right: 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Text(
                              loc.languageLabel,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            _buildLanguageDropdown(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Operation Selection Buttons
                Text(
                  loc.selectOperation,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Single row of operation buttons
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildOperationButton(
                        Operation.addition,
                        '+',
                        loc.add,
                        Colors.green,
                      ),
                      const SizedBox(width: 10),
                      _buildOperationButton(
                        Operation.subtraction,
                        '−',
                        loc.subtract,
                        Colors.red,
                      ),
                      const SizedBox(width: 10),
                      _buildOperationButton(
                        Operation.multiplication,
                        '×',
                        loc.multiply,
                        Colors.purple,
                      ),
                      const SizedBox(width: 10),
                      _buildOperationButton(
                        Operation.division,
                        '÷',
                        loc.divide,
                        Colors.orange,
                      ),
                      const SizedBox(width: 10),
                      _buildOperationButton(
                        Operation.mixed,
                        '±×÷',
                        loc.mixed,
                        Colors.teal,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(Difficulty difficulty, String label) {
    bool isSelected = selectedDifficulty == difficulty;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDifficulty = difficulty;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerModeButton(PlayerMode mode, String label) {
    bool isSelected = selectedPlayerMode == mode;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPlayerMode = mode;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return DropdownButton<Language>(
      value: selectedLanguage,
      dropdownColor: Colors.blue.shade700,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      underline: Container(
        height: 1,
        color: Colors.white.withOpacity(0.5),
      ),
      items: [
        DropdownMenuItem(
          value: Language.english,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🇺🇸', style: TextStyle(fontSize: 16)),
              SizedBox(width: 5),
              Text('EN', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        DropdownMenuItem(
          value: Language.german,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🇩🇪', style: TextStyle(fontSize: 16)),
              SizedBox(width: 5),
              Text('DE', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        DropdownMenuItem(
          value: Language.french,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🇫🇷', style: TextStyle(fontSize: 16)),
              SizedBox(width: 5),
              Text('FR', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
      onChanged: (Language? newLanguage) {
        if (newLanguage != null) {
          _saveLanguage(newLanguage);
        }
      },
    );
  }

  Widget _buildOperationButton(Operation operation, String symbol, String label, Color color) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen(
              settings: GameSettings(
                difficulty: selectedDifficulty,
                playerMode: selectedPlayerMode,
                rotateButtons: rotateButtons,
                operation: operation,
                soundEnabled: soundEnabled,
              ),
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        minimumSize: const Size(120, 70),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            symbol,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final GameSettings settings;
  
  const GameScreen({super.key, required this.settings});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with TickerProviderStateMixin {
  // Game state
  int player1Score = 0;
  int player2Score = 0;
  int currentRound = 1;
  static const int totalRounds = 10;
  
  int num1 = 0;
  int num2 = 0;
  int result = 0;
  int correctAnswer = 0;
  List<int> answers = [];
  bool isReverseChallenge = false; // true when guessing second operand
  Operation currentOperation = Operation.addition; // for mixed mode
  Timer? gameTimer;
  int timeLeft = 10;
  bool gameActive = true;
  bool isPaused = false;
  bool player1Answered = false;
  bool player2Answered = false;
  
  late AnimationController _timerController;
  late AnimationController _feedbackController;
  String feedbackText = '';
  Color feedbackColor = Colors.green;
  final Random _random = Random();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _timerController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _feedbackController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _generateNewChallenge();
    _startTimer();
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    _timerController.dispose();
    _feedbackController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playSound(String soundName) async {
    if (widget.settings.soundEnabled) {
      try {
        await _audioPlayer.play(AssetSource('sounds/$soundName.mp3'));
      } catch (e) {
        // Handle error silently - sound is not critical for app functionality
        print('Error playing sound: $e');
      }
    }
  }

  (int, int) _getDifficultyRange(Operation operation) {
    switch (operation) {
      case Operation.addition:
      case Operation.mixed:
        switch (widget.settings.difficulty) {
          case Difficulty.easy:
            return (1, 20);  // 1-20
          case Difficulty.medium:
            return (10, 50); // 10-50
          case Difficulty.hard:
            return (25, 100); // 25-100
        }
      case Operation.subtraction:
        switch (widget.settings.difficulty) {
          case Difficulty.easy:
            return (1, 20);  // 1-20
          case Difficulty.medium:
            return (10, 50); // 10-50
          case Difficulty.hard:
            return (25, 100); // 25-100
        }
      case Operation.multiplication:
        switch (widget.settings.difficulty) {
          case Difficulty.easy:
            return (1, 10);  // 1-10
          case Difficulty.medium:
            return (2, 15);  // 2-15
          case Difficulty.hard:
            return (5, 20);  // 5-20
        }
      case Operation.division:
        switch (widget.settings.difficulty) {
          case Difficulty.easy:
            return (2, 5);   // divisors 2-5
          case Difficulty.medium:
            return (2, 10);  // divisors 2-10
          case Difficulty.hard:
            return (2, 15);  // divisors 2-15
        }
    }
  }

  void _generateNewChallenge() {
    // For mixed mode, randomly select an operation
    if (widget.settings.operation == Operation.mixed) {
      List<Operation> operations = [Operation.addition, Operation.subtraction, Operation.multiplication, Operation.division];
      currentOperation = operations[_random.nextInt(4)];
    } else {
      currentOperation = widget.settings.operation;
    }
    
    final (minVal, maxVal) = _getDifficultyRange(currentOperation);
    
    // Randomly choose between standard and reverse challenge
    isReverseChallenge = _random.nextBool();
    
    switch (currentOperation) {
      case Operation.addition:
        num1 = _random.nextInt(maxVal - minVal + 1) + minVal;
        num2 = _random.nextInt(maxVal - minVal + 1) + minVal;
        result = num1 + num2;
        correctAnswer = isReverseChallenge ? num2 : result;
        break;
        
      case Operation.subtraction:
        num1 = _random.nextInt(maxVal - minVal + 1) + minVal;
        num2 = _random.nextInt(num1) + 1; // Ensure positive result
        result = num1 - num2;
        correctAnswer = isReverseChallenge ? num2 : result;
        break;
        
      case Operation.multiplication:
        num1 = _random.nextInt(maxVal - minVal + 1) + minVal;
        num2 = _random.nextInt(maxVal - minVal + 1) + minVal;
        result = num1 * num2;
        correctAnswer = isReverseChallenge ? num2 : result;
        break;
        
      case Operation.division:
        num2 = _random.nextInt(maxVal - minVal + 1) + minVal; // divisor
        int multiplier = _random.nextInt(20) + 5;
        num1 = num2 * multiplier; // dividend
        result = num1 ~/ num2;
        correctAnswer = isReverseChallenge ? num2 : result;
        break;
        
      case Operation.mixed:
        // This case shouldn't be reached, but just in case
        currentOperation = Operation.addition;
        num1 = _random.nextInt(maxVal - minVal + 1) + minVal;
        num2 = _random.nextInt(maxVal - minVal + 1) + minVal;
        result = num1 + num2;
        correctAnswer = isReverseChallenge ? num2 : result;
        break;
    }

    // Generate wrong answers based on challenge type
    List<int> wrongAnswers = [];
    while (wrongAnswers.length < 2) {
      int wrong;
      
      if (isReverseChallenge) {
        // For reverse challenges, generate wrong second operands
        if (widget.settings.operation == Operation.multiplication || widget.settings.operation == Operation.division) {
          wrong = correctAnswer + (_random.nextInt(6) - 3); // smaller range for factors/divisors
        } else {
          wrong = correctAnswer + (_random.nextInt(10) - 5);
        }
      } else {
        // For standard challenges, generate wrong results
        if (widget.settings.operation == Operation.multiplication) {
          wrong = correctAnswer + (_random.nextInt(20) - 10);
        } else {
          wrong = correctAnswer + (_random.nextInt(10) - 5);
        }
      }
      
      if (wrong > 0 && wrong != correctAnswer && !wrongAnswers.contains(wrong)) {
        wrongAnswers.add(wrong);
      }
    }

    answers = [correctAnswer, ...wrongAnswers];
    answers.shuffle();

    setState(() {
      timeLeft = 10;
      gameActive = true;
      feedbackText = '';
      player1Answered = false;
      player2Answered = false;
    });

    _timerController.reset();
    if (!isPaused) {
      _timerController.forward();
    }
  }

  void _startTimer() {
    gameTimer?.cancel();
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused && timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else if (timeLeft <= 0) {
        _timeOut();
      }
    });
  }

  void _pauseGame() {
    setState(() {
      isPaused = !isPaused;
    });
    
    if (isPaused) {
      _timerController.stop();
    } else {
      _timerController.forward();
    }
  }

  void _timeOut() {
    gameTimer?.cancel();
    _timerController.stop();
    setState(() {
      gameActive = false;
      feedbackText = 'Time\'s up! Answer was $correctAnswer';
      feedbackColor = Colors.red;
    });
    _showFeedback();
    _playSound('timeout');
    
    Timer(const Duration(seconds: 2), () {
      _nextRound();
    });
  }

  void _nextRound() {
    if (currentRound >= totalRounds) {
      _endGame();
    } else {
      setState(() {
        currentRound++;
      });
      _generateNewChallenge();
      _startTimer();
    }
  }

  void _endGame() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          result: GameResult(
            player1Score: player1Score,
            player2Score: player2Score,
            totalRounds: totalRounds,
            playerMode: widget.settings.playerMode,
            operation: widget.settings.operation,
          ),
          settings: widget.settings,
        ),
      ),
    );
  }

  void _answerSelected(int selectedAnswer, int player) {
    if (!gameActive || isPaused) return;
    
    // In single player mode, player is always 1
    // In two player mode, check if this player already answered
    if (widget.settings.playerMode == PlayerMode.twoPlayer) {
      if (player == 1 && player1Answered) return;
      if (player == 2 && player2Answered) return;
      
      setState(() {
        if (player == 1) player1Answered = true;
        if (player == 2) player2Answered = true;
      });
    }

    bool isCorrect = selectedAnswer == correctAnswer;
    
    if (isCorrect) {
      setState(() {
        if (player == 1) {
          player1Score++;
        } else {
          player2Score++;
        }
      });
    }

    // In single player mode, advance immediately
    // In two player mode, also advance immediately after first answer
    gameTimer?.cancel();
    _timerController.stop();
    
    setState(() {
      gameActive = false;
      if (widget.settings.playerMode == PlayerMode.single) {
        feedbackText = isCorrect ? 'Correct! 🎉' : 'Try again! Answer was $correctAnswer';
        feedbackColor = isCorrect ? Colors.green : Colors.red;
      } else {
        // Two player feedback - show who answered first
        if (isCorrect) {
          feedbackText = 'Player $player got it right! 🎉';
          feedbackColor = Colors.green;
        } else {
          feedbackText = 'Player $player tried! Answer was $correctAnswer';
          feedbackColor = Colors.red;
        }
      }
    });
    
    _showFeedback();
    _playSound(isCorrect ? 'correct' : 'wrong');
    
    Timer(const Duration(seconds: 1), () {
      _nextRound();
    });
  }

  void _showFeedback() {
    _feedbackController.forward().then((_) {
      Timer(const Duration(milliseconds: 800), () {
        _feedbackController.reverse();
      });
    });
  }

  void _returnToStart() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
    );
  }

  String _getOperationSymbol() {
    switch (currentOperation) {
      case Operation.addition:
        return '+';
      case Operation.subtraction:
        return '−';
      case Operation.multiplication:
        return '×';
      case Operation.division:
        return '÷';
      case Operation.mixed:
        return '+'; // fallback, shouldn't happen
    }
  }

  Widget _buildAnswerButton(int answer, String keyboardKey, int player) {
    bool playerAnswered = (player == 1 && player1Answered) || 
                         (player == 2 && player2Answered);
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OrientationBuilder(
        builder: (context, orientation) {
          // Use rotation setting from GameSettings instead of device orientation for Windows
          bool shouldRotate = widget.settings.rotateButtons;
          double buttonHeight = shouldRotate ? 60 : 80;
          double buttonWidth = shouldRotate ? 150 : 200;
          double fontSize = shouldRotate ? 20 : 28;

          return Transform.rotate(
            angle: shouldRotate ? -pi / 2 : 0,
            child: SizedBox(
              height: buttonHeight,
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: (gameActive && !isPaused && !playerAnswered) 
                    ? () => _answerSelected(answer, player) 
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: (gameActive && !isPaused && !playerAnswered) 
                      ? Colors.orange 
                      : Colors.grey,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$answer',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        keyboardKey,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScoreDisplay() {
    if (widget.settings.playerMode == PlayerMode.twoPlayer) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: player1Answered ? Colors.green : Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'P1: $player1Score${player1Answered ? ' ✓' : ''}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: player2Answered ? Colors.green : Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'P2: $player2Score${player2Answered ? ' ✓' : ''}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    } else {
      return Text(
        'Score: $player1Score',
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              offset: Offset(1, 1),
              blurRadius: 2,
              color: Colors.black45,
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue, Colors.blue, Colors.indigo],
          ),
        ),
        child: RawKeyboardListener(
          focusNode: FocusNode()..requestFocus(),
          onKey: (RawKeyEvent event) {
            if (event is RawKeyDownEvent && gameActive && !isPaused) {
              // Single player or Player 1 controls
              if (event.logicalKey == LogicalKeyboardKey.keyQ && !player1Answered) {
                _answerSelected(answers[0], 1);
              } else if (event.logicalKey == LogicalKeyboardKey.keyW && !player1Answered) {
                _answerSelected(answers[1], 1);
              } else if (event.logicalKey == LogicalKeyboardKey.keyE && !player1Answered) {
                _answerSelected(answers[2], 1);
              }
              
              // Player 2 controls (right side of keyboard)
              if (widget.settings.playerMode == PlayerMode.twoPlayer) {
                if (event.logicalKey == LogicalKeyboardKey.keyI && !player2Answered) {
                  _answerSelected(answers[0], 2);
                } else if (event.logicalKey == LogicalKeyboardKey.keyO && !player2Answered) {
                  _answerSelected(answers[1], 2);
                } else if (event.logicalKey == LogicalKeyboardKey.keyP && !player2Answered) {
                  _answerSelected(answers[2], 2);
                }
              }
            }
            if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {
              _pauseGame();
            }
          },
          child: OrientationBuilder(
            builder: (context, orientation) {
              bool isPortrait = orientation == Orientation.portrait;

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      // Left side rotated buttons (Player 1 in two-player mode)
                      if (widget.settings.rotateButtons && widget.settings.playerMode == PlayerMode.twoPlayer) ...[
                        SizedBox(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'P1',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              _buildAnswerButton(answers[0], 'Q', 1),
                              _buildAnswerButton(answers[1], 'W', 1),
                              _buildAnswerButton(answers[2], 'E', 1),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                      
                      // Main game area
                      Expanded(
                        child: Column(
                          children: [
                            // Header with controls, score and round
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: _returnToStart,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      child: const Icon(Icons.home, size: 20),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: _pauseGame,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isPaused ? Colors.green : Colors.orange,
                                        foregroundColor: Colors.white,
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      child: Icon(isPaused ? Icons.play_arrow : Icons.pause, size: 20),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          // Toggle sound - in a real app this would be managed by a provider
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: widget.settings.soundEnabled ? Colors.blue : Colors.grey,
                                        foregroundColor: Colors.white,
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      child: Icon(
                                        widget.settings.soundEnabled ? Icons.volume_up : Icons.volume_off,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                
                                // Round counter
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Round $currentRound/$totalRounds',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                
                                _buildScoreDisplay(),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Pause overlay
                            if (isPaused)
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'PAUSED\nPress SPACE or pause button to resume',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            else ...[
                              // Timer
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 4),
                                ),
                                child: AnimatedBuilder(
                                  animation: _timerController,
                                  builder: (context, child) {
                                    return CircularProgressIndicator(
                                      value: 1.0 - _timerController.value,
                                      strokeWidth: 6,
                                      backgroundColor: Colors.white.withOpacity(0.3),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        timeLeft <= 3 ? Colors.red : Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                '$timeLeft',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),

                              const Spacer(),

                              // Challenge display
                              Container(
                                padding: const EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  isReverseChallenge 
                                    ? '$num1 ${_getOperationSymbol()} ? = $result'
                                    : '$num1 ${_getOperationSymbol()} $num2 = ?',
                                  style: const TextStyle(
                                    fontSize: 64,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ),

                              const Spacer(),

                              // Feedback
                              AnimatedBuilder(
                                animation: _feedbackController,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: 1.0 + (_feedbackController.value * 0.2),
                                    child: Opacity(
                                      opacity: _feedbackController.value,
                                      child: Text(
                                        feedbackText,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: feedbackColor,
                                          shadows: const [
                                            Shadow(
                                              offset: Offset(1, 1),
                                              blurRadius: 2,
                                              color: Colors.black45,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 20),

                              // Answer buttons (when not using rotated side layout)
                              if (!widget.settings.rotateButtons) ...[
                                if (widget.settings.playerMode == PlayerMode.single) ...[
                                  if (isPortrait)
                                    Column(
                                      children: [
                                        _buildAnswerButton(answers[0], 'Q', 1),
                                        _buildAnswerButton(answers[1], 'W', 1),
                                        _buildAnswerButton(answers[2], 'E', 1),
                                      ],
                                    )
                                  else
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildAnswerButton(answers[0], 'Q', 1),
                                        _buildAnswerButton(answers[1], 'W', 1),
                                        _buildAnswerButton(answers[2], 'E', 1),
                                      ],
                                    ),
                                ] else ...[
                                  // Two player mode - side by side (when not rotated)
                                  Row(
                                    children: [
                                      // Player 1 side
                                      Expanded(
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Player 1',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            _buildAnswerButton(answers[0], 'Q', 1),
                                            _buildAnswerButton(answers[1], 'W', 1),
                                            _buildAnswerButton(answers[2], 'E', 1),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      // Player 2 side
                                      Expanded(
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Player 2',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            _buildAnswerButton(answers[0], 'I', 2),
                                            _buildAnswerButton(answers[1], 'O', 2),
                                            _buildAnswerButton(answers[2], 'P', 2),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ] else if (widget.settings.playerMode == PlayerMode.single) ...[
                                // Single player rotated buttons in center
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildAnswerButton(answers[0], 'Q', 1),
                                    _buildAnswerButton(answers[1], 'W', 1),
                                    _buildAnswerButton(answers[2], 'E', 1),
                                  ],
                                ),
                              ],

                              const SizedBox(height: 10),
                              
                              // Instructions
                              Text(
                                widget.settings.playerMode == PlayerMode.single
                                    ? 'Use Q, W, E keys • Press SPACE to pause'
                                    : 'Player 1: Q, W, E • Player 2: I, O, P • First to answer wins! • SPACE to pause',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ],

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),

                      // Right side rotated buttons (Player 2 in two-player mode)
                      if (widget.settings.rotateButtons && widget.settings.playerMode == PlayerMode.twoPlayer) ...[
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'P2',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              _buildAnswerButton(answers[0], 'I', 2),
                              _buildAnswerButton(answers[1], 'O', 2),
                              _buildAnswerButton(answers[2], 'P', 2),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final GameResult result;
  final GameSettings settings;

  const ResultScreen({super.key, required this.result, required this.settings});

  String _getOperationName(Operation operation) {
    switch (operation) {
      case Operation.addition:
        return 'Addition';
      case Operation.subtraction:
        return 'Subtraction';
      case Operation.multiplication:
        return 'Multiplication';
      case Operation.division:
        return 'Division';
      case Operation.mixed:
        return 'Mixed Math';
    }
  }

  @override
  Widget build(BuildContext context) {
    String winner = '';
    String subtitle = '';
    
    if (result.playerMode == PlayerMode.single) {
      winner = 'Game Complete!';
      subtitle = 'You got ${result.player1Score} out of ${result.totalRounds} ${_getOperationName(result.operation).toLowerCase()} problems correct';
    } else {
      if (result.player1Score > result.player2Score) {
        winner = 'Player 1 Wins! 🎉';
        subtitle = 'Player 1: ${result.player1Score} • Player 2: ${result.player2Score}';
      } else if (result.player2Score > result.player1Score) {
        winner = 'Player 2 Wins! 🎉';
        subtitle = 'Player 1: ${result.player1Score} • Player 2: ${result.player2Score}';
      } else {
        winner = 'It\'s a Tie! 🤝';
        subtitle = 'Both players got ${result.player1Score} correct';
      }
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue, Colors.blue, Colors.indigo],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Sound toggle button in top right
              Positioned(
                top: 20,
                right: 20,
                child: ElevatedButton(
                  onPressed: () {
                    // Toggle sound - in a real app this would be managed by a provider
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: settings.soundEnabled ? Colors.blue : Colors.grey,
                    foregroundColor: Colors.white,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                  ),
                  child: Icon(
                    settings.soundEnabled ? Icons.volume_up : Icons.volume_off,
                    size: 20,
                  ),
                ),
              ),
              
              // Main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      size: 120,
                      color: Colors.yellow,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      winner,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 60),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const SplashScreen()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'PLAY AGAIN',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
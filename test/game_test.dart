import 'package:bulmaca_motoru/bulmaca_motoru.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oyun_renkli_nonogram/oyun_renkli_nonogram.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('33 dilde ad ve anlatım', () {
    expect(renkliResimConfig.title.length, 33);
    expect(renkliResimConfig.tagline.length, 33);
    for (final s in renkliResimConfig.tutorial) {
      expect(s.text.length, 33);
    }
  });

  test('bölümler üretilir, doğrulanır ve kaydedilip geri yüklenir', () {
    final planner = LevelPlanner(gameId: renkliResimId, optionalMechanics: const []);
    for (final lv in [1, 77, 1500, 33333, 99999]) {
      final gl = renkliResimRules.build(planner.spec(lv));
      expect(gl.validation.ok, isTrue, reason: 'bölüm $lv');
      final k = renkliResimRules.kindForLevel(gl.spec.difficulty);
      final start = k.initial(gl.puzzle);
      expect(PState.restore(start.serialize(), gl.puzzle), isNotNull);
      expect(PLevel.fromJson(gl.puzzle.toJson()).toJson().toString(), gl.puzzle.toJson().toString());
    }
  });
}

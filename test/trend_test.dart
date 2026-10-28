import 'package:flutter_test/flutter_test.dart';
import 'package:sati/data/trend.dart';

void main() {
  group('ewma', () {
    test('empty series -> empty', () {
      expect(ewma([]), isEmpty);
    });

    test('single value -> itself', () {
      expect(ewma([7]), [7.0]);
    });

    test('smooths toward later values', () {
      final out = ewma([10, 0], alpha: 0.5);
      expect(out.first, 10.0);
      expect(out.last, 5.0);
    });
  });

  group('trendDelta', () {
    test('empty', () {
      expect(trendDelta([]), contains('start your trend'));
    });

    test('single', () {
      expect(trendDelta([5]), contains('One data point'));
    });

    test('falling', () {
      expect(trendDelta([8, 3]), contains('shine is wearing off'));
    });

    test('rising', () {
      expect(trendDelta([3, 8]), contains('still feels rewarding'));
    });
  });
}

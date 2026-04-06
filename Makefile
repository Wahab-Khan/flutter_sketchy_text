# Makefile for flutter_sketchy_text

.PHONY: clean format analyze dry-run publish release

# Clean project
clean:
	@echo "Cleaning project..."
	@flutter clean
	@flutter pub get

# Format code
format:
	@echo "Formatting Dart code..."
	@dart format .

# Analyze code
analyze: format
	@echo "Analyzing Dart code..."
	@dart analyze

# Run publish dry-run to ensure the package meets pub.dev requirements
dry-run: analyze
	@echo "Running pub publish dry-run..."
	@dart pub publish --dry-run

# Publish the package to pub.dev
publish:
	@echo "Publishing package to pub.dev..."
	@dart pub publish

# Full release sequence: format, analyze, dry-run, and then instruct user
release: dry-run
	@echo "==========================================================="
	@echo "✅ Pre-flight checks passed! (Format, Analyze, and Dry-Run)"
	@echo "==========================================================="
	@echo "To finalize and publish the release, run:"
	@echo "  make publish"

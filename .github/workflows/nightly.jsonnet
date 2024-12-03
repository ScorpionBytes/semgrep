// Cron to verify that the release is still working (at least in dry-mode),
// and that the Semgrep Homebrew formula still work.

local semgrep = import 'libs/semgrep.libsonnet';
local release_homebrew = import 'release-homebrew.jsonnet';

// ----------------------------------------------------------------------------
// The Workflow
// ----------------------------------------------------------------------------
{
  name: 'nightly',
  on: 'push',
  jobs: {
    'brew-build': release_homebrew.export.brew_build,
    'release-dry-run': {
      uses: './.github/workflows/release.yml',
      secrets: 'inherit',
      with: {
        'dry-run': true,
      },
    },
  },
}

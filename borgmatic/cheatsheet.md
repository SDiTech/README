<!-- source: https://ovelny.sh/chaos/tools-cheatsheets/borgmatic/ -->

# Borgmatic

Easier backups with borg. Install it with `pipx install borgmatic` or install borgbackup preferably through your distribution's package manager.

## Commands

```bash
# Check if config file is valid:
borgmatic config validate

# Init encrypted repo according to your config.
# Blake 2 is usually a bit faster:
borgmatic init --encryption repokey-blake2

# List backups:
borgmatic list

# Export encryption key, don't lose it:
borgmatic key export

# Perform pruning, compaction, create backups
# according to your config file, and check backups
# for consistency:
borgmatic --verbosity 1 --list --stats

# Chaining specific commands can skip default others.
# For instance, this does as the default borgmatic command
# but omit checks for consistency:
borgmatic prune compact create --verbosity 1 --list --stats

# Check archives for consistency.
# This is usually slow, brace yourself:
borgmatic check --progress --repository <repository label in config>

# Do a dry run extract with the latest archive.
# This will restore the full absolute path, if you
# want to avoid that, use --strip-components <num>
# where <num> removes a set number of the leading path:
# "--strip-components 2" for "home/user/Documents" will
# remove "home/user" from the path. Never use leading
# slashes for --path (e.g. "home/user" and not "/home/user"):
borgmatic --dry-run -v 2 extract --archive latest --path <path to restore>

# Perform a real extract if everything is correct on dry run:
borgmatic extract --verbosity 1 --list --stats --archive latest --path <path to restore>

# Do a dry run to delete an archive:
borgmatic --dry-run -v 2 delete --repository <repository label in config> --archive <latest or archive name as shown in borgmatic list output>

# Perform real archive deletion if everything is correct on dry run.
# We chain delete and compact to actually free up space afterwards:
borgmatic delete compact --verbosity 2 --list --stats --repository <repository label in config> --archive <latest or archive name as shown in borgmatic list output>

# Remove a directory or a file in all archives. All "borg recreate"
# commands can be dangerous, so be careful. Compact must be run
# afterwards to reclaim saved space:
borgmatic --verbosity 2 borg --repository <repository label in config> recreate --exclude home/<user>/<directory> && borgmatic compact --verbosity 2
```

## Configuration template

A simple but sufficient configuration template in `~/.config/borgmatic/config.yaml` can look like this:

```bash
encryption_passcommand: <shell command to get encryption passphrase>

archive_name_format: '{hostname}-{now:%d-%m-%Y-%H:%M:%S}'
compression: zstd
retries: 5
retry_wait: 30

keep_daily: 7
keep_weekly: 4
keep_monthly: 6
keep_yearly: 1

repositories:
  - path: /mnt/backups/<repository name>
    label: local

source_directories:
  - /home/<user>
  - /mnt/<other_drive>
  - /mnt/<another_drive>

exclude_patterns:
  - /home/*/.cache
  - /home/*/.zsh_history
  - /home/*/.bash_history
  - /mnt/*/lost+found

exclude_if_present:
  - .nobackup
```

modified from source: https://ovelny.sh/chaos/tools-cheatsheets/borgmatic/ 
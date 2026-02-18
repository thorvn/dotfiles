function clean_fish_history --description "Remove noisy and sensitive entries from fish history"
    # --- Exact matches: single-word noise commands ---
    set -l exact_cmds \
        z cd ls ll la eza pwd tree \
        g gss gls gfa \
        exit clear history true false \
        v nvim vim vi \
        lg lazygit cc done tm zz zellij cat bat p pnpm \
        which whoami hostname uptime date cal df du top htop

    for cmd in $exact_cmds
        builtin history delete --exact --case-sensitive -- $cmd 2>/dev/null
    end

    # --- Prefix matches: commands starting with sensitive tools ---
    set -l prefix_patterns \
        'sudo ' passwd 'security ' 'op ' \
        'ssh ' ssh- 'scp ' 'sftp ' \
        'git push' 'git commit' 'git config' 'git remote' 'git clone' \
        'g push' 'g commit' 'g config' 'g remote' 'g clone' \
        mysql psql mongo mongosh redis-cli sqlite3 \
        'curl ' 'wget ' 'http ' 'https ' \
        'aws ' 'gcloud ' 'az ' 'terraform ' 'kubectl ' 'helm ' 'docker login' \
        'export ' 'set -gx ' 'set -Ux ' \
        'npm login' 'npm token' 'yarn login' 'gem push' \
        'openssl ' 'gpg ' 'age ' \
        'history delete' 'history search' 'history clear'

    for pattern in $prefix_patterns
        builtin history delete --prefix --case-sensitive -- $pattern 2>/dev/null
    end

    # --- Contains matches: entries with sensitive keywords anywhere (case-insensitive) ---
    set -l contains_patterns \
        password passwd token api_key apikey \
        secret_key secret_access access_key private_key client_secret \
        authorization bearer \
        id_rsa id_ed25519 .pem '.key.pem' \
        '://' \
        _TOKEN= _KEY= _SECRET= _PASSWORD= _PASS= _AUTH= PGPASSWORD

    for pattern in $contains_patterns
        builtin history delete --contains -- $pattern 2>/dev/null
    end

    builtin history save
end

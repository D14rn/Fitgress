if [ -z "${FITGRESS_JDK_HOME:-}" ]; then
    PROJECT_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
    ENV_FILE="$PROJECT_ROOT/.env"
    if [ -f "$ENV_FILE" ]; then
        while IFS='=' read -r name value || [ -n "$name" ]; do
            value="${value%$'\r'}"
            if [ "$name" = "FITGRESS_JDK_HOME" ]; then
                value="${value#"${value%%[![:space:]]*}"}"
                value="${value%"${value##*[![:space:]]}"}"
                if [ "${value#\"}" != "$value" ] && [ "${value%\"}" != "$value" ]; then
                    value="${value#\"}"
                    value="${value%\"}"
                elif [ "${value#\'}" != "$value" ] && [ "${value%\'}" != "$value" ]; then
                    value="${value#\'}"
                    value="${value%\'}"
                fi
                if [ -n "$value" ]; then
                    FITGRESS_JDK_HOME="$value"
                    break
                fi
            fi
        done < "$ENV_FILE"
    fi
fi

if [ -z "${FITGRESS_JDK_HOME:-}" ]; then
    printf '%s\n' 'FITGRESS_JDK_HOME is not set. Add your JDK 25 path to FITGRESS_JDK_HOME in the repository .env file, or set it in this terminal.' >&2
    return 1 2>/dev/null || exit 1
fi

if [ ! -x "$FITGRESS_JDK_HOME/bin/java" ]; then
    printf 'No executable JDK found at FITGRESS_JDK_HOME (%s).\n' "$FITGRESS_JDK_HOME" >&2
    return 1 2>/dev/null || exit 1
fi

export JAVA_HOME="$FITGRESS_JDK_HOME"
export PATH="$JAVA_HOME/bin${PATH:+:$PATH}"
printf 'Using JDK at %s\n' "$JAVA_HOME"

if [ -z "$FITGRESS_JDK_HOME" ]; then
    printf '%s\n' 'FITGRESS_JDK_HOME is not set. Set it to the path of your JDK 25 directory first.' >&2
    return 1 2>/dev/null || exit 1
fi

if [ ! -x "$FITGRESS_JDK_HOME/bin/java" ]; then
    printf 'No executable JDK found at FITGRESS_JDK_HOME (%s).\n' "$FITGRESS_JDK_HOME" >&2
    return 1 2>/dev/null || exit 1
fi

export JAVA_HOME="$FITGRESS_JDK_HOME"
export PATH="$JAVA_HOME/bin${PATH:+:$PATH}"
printf 'Using JDK at %s\n' "$JAVA_HOME"

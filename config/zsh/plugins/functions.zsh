function copyfile() {
    printf 'file://%s\n' "$(realpath "$1")" | wl-copy --type text/uri-list
}

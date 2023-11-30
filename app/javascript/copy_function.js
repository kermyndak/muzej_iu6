function copy_text(id) {
    var copyText = document.getElementById("password" + id);
    copyText.select();
    document.execCommand("copy");
}

const save_btn = document.getElementById('save-btn');
const slider = document.getElementById('save-slider');
const close_btn = document.getElementById('close-btn');
const images = document.getElementById("images");
const some_files = document.getElementById("some_files");

save_btn.addEventListener('click', () => {
    if (images.files.length || some_files.files.length)
        slider.classList.add("slide-left");
})

slider.addEventListener('animationend', () => {
    slider.classList.remove("slide-left")
    slider.classList.remove('fade-out')
})

close_btn.addEventListener('click', () => {
    slider.classList.add("fade-out");
})
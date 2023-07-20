function stop_destroy(){
    let button = document.getElementById("button_destroy")
    let timer_destroy = document.getElementById("timer_destroy")
    let counter = 5
    let timer = setInterval(() => {
        if (counter < 0) {clearInterval(timer), document.getElementById('result').click()};
        timer_destroy.innerHTML = counter--
    }, 1000)
}
const demo = true;
const connection_status = document.getElementById('connection-status');
const payload = document.getElementById('custom-payload');
const send = document.getElementById('send');
const receive = document.getElementById('receive');

const add_leading_zero = function(i) {
    if (i < 10) i = "0" + i;
    return i;
}

const get_date = function() {
    const d = new Date();
    const day = add_leading_zero(d.getDate());
    const month = add_leading_zero(d.getMonth() + 1);
    const date = [
        d.getFullYear(),
        month,
        day
    ].join("-");
    const time = [
        add_leading_zero(d.getHours()),
        add_leading_zero(d.getMinutes()),
        add_leading_zero(d.getSeconds())
    ].join(":")
    return date + "T" + time;
}

const pretty_json = function(str) {
    const obj = JSON.parse(str);
    return JSON.stringify(obj, null, 2);
}

const print_message = function(str) {
    const time = get_date();
    const msg_count = document.getElementsByClassName('msg').length + 1;
    const html = "<label for=" + msg_count + ">"
        + "msg: " + msg_count + ", received: " + time
        + "</label>"
        + "<pre id=" + msg_count
        + " class='msg'>" + pretty_json(str) + "</pre>";
    receive.innerHTML = html + receive.innerHTML;
}

const resize = function() {
    receive.style.height = document.documentElement.clientHeight - 100 + "px";
}

document.addEventListener("DOMContentLoaded", function() {
    resize();
    if (demo) {
        connection_status.innerHTML = 'Connected to 127.0.0.1:8800';
        payload.value = pretty_json('{"command": "ping"}');
        send.addEventListener("click", async function() {
            const date = get_date();
            const json = '{"command": "pong", "ts":"' + date + '"}';
            await new Promise(resolve => setTimeout(resolve, 250));
            print_message(json);
        });
    }
});

window.addEventListener('resize', resize);

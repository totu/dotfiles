const demo = true;
let custom_topic = "";
let we_pro = false;
const pop = document.getElementById('pop');
const pro = document.getElementById('pro');
const connection_status = document.getElementById('connection-status');
const payload = document.getElementById('payload');
const custom_payload = document.getElementById('custom-payload');
const title = document.getElementById('title');
const command = document.getElementById('command');
const topic = document.getElementById('topic');
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

const pretty_json = function(obj) {
    return JSON.stringify(obj, null, 2);
}

const print_message = function(str) {
    const time = get_date();
    const msg_count = document.getElementsByClassName('msg').length + 1;
    const html = "<label for=" + msg_count + ">"
        + topic.value + ", " + time
        + "</label>"
        + "<pre id=" + msg_count
        + " class='msg'>" + pretty_json(str) + "</pre>";
    receive.innerHTML = html + receive.innerHTML;
}

const resize = function() {
    receive.style.height = document.documentElement.clientHeight - 100 + "px";
}

const fields = {
    "ping": {
        "topic": "kone/to/kcegc/ping",
        "fields": {
            "request_id": 1
        },
        "demo": '{"request_id": 1, "ts":"2020-01-04T00:00:00"}'
    },
    "call": {
        "topic": "kone/to/kcegc/call_v1",
        "fields": {
            "floor": 1,
            "side": 1,
            "direction": null
        },
        "demo": '{"command": "call", "state":"accepted", "floor": 1, "side": 1, "direction": "UP"}'
    }
}

const field_to_payload = function(name, value=null) {
    let html = "<label class='payload-label' for='"
        + name + "'>"
        + name + "</label>"
        + "<input class='" + value + " payload-input' id='"
        + name + "' type='text' value='"
        if (value == null) {
            html += "' placeholder='OPTIONAL' ";
        }
        html += value + "'><br>";
    payload.innerHTML += html;
}

const update = function() {
    payload.innerHTML = "";
    if (command.value != "custom") {
        const field = fields[command.value];
        topic.value = field.topic;
        if (we_pro) {
            topic.readOnly = false;
            topic.classList.remove('readonly');
            title.style.display = "block";
            payload.innerHTML = "<textarea id='custom-payload' rows=10>"
                + pretty_json(field.fields)
                + "</textarea>";
        } else {
            topic.readOnly = true;
            topic.classList.add('readonly');
            title.style.display = "none";
            for (f in field.fields) {
                field_to_payload(f, field.fields[f]);
            }
        }
    } else {
        topic.readOnly = false;
        topic.classList.remove('readonly');
        topic.value = custom_topic;
        title.style.display = "block";
        payload.innerHTML = "<textarea id='custom-payload' rows=10></textarea>";
    }
}

document.addEventListener("DOMContentLoaded", function() {
    resize();
    we_pro = (window.localStorage.getItem('we_pro') == "true") ? true : false;
    pro.checked = we_pro;
    console.log(we_pro);

    if (demo) {
        connection_status.innerHTML = 'Connected to 127.0.0.1:8800';

        pro.addEventListener("change", function() {
            we_pro = this.checked;
            window.localStorage.setItem('we_pro', we_pro);
            update();
        });

        topic.addEventListener("change", function() {
            custom_topic = this.value;
        });

        command.addEventListener("change", function() {
            update()
        });

        pop.addEventListener("click", function() {
            pop.style.display = "none";
        });

        send.addEventListener("click", async function() {
            const date = get_date();
            let json = "";
            if (command.value == "custom") {
                json = custom_payload.value;
                if (json == "") {
                    pop.innerHTML = "Payload can not be empty!";
                    pop.style.display = "block";
                    return;
                } else {
                    console.log(json);
                    try {
                        json = JSON.parse(json);
                    } catch (e) {
                        pop.innerHTML = "That doesn't look like valid JSON <span class='emoji'>🤔</span>";
                        pop.style.display = "block";
                        return;
                    }
                }
            } else {
                json = fields[command.value].demo;
                console.log(json);
                json = JSON.parse(json);
            }
            await new Promise(resolve => setTimeout(resolve, 250));
            print_message(json);
        });
    }
});

window.addEventListener('resize', resize);

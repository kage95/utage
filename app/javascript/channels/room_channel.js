import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
    const data = document.getElementById("data")
    const event_id = data.getAttribute("data-event-id")
    const user_id = data.getAttribute("data-user-id")

    window.messageContainer = document.getElementById('message-container')

    if (messageContainer === null) {
        return
    }

    consumer.subscriptions.create({channel: "RoomChannel", event_id: event_id, user_id: user_id}, {
        connected() {
        },

        disconnected() {
        },

        received(data) {
            const message = `<div class="my-message d-flex flex-row-reverse align-items-start mb-4">${data['message']}</div>`
            messageContainer.insertAdjacentHTML('beforeend', message)
        }
    })
})
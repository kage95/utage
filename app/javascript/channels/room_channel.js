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
            messageContainer.insertAdjacentHTML('beforeend', data['message'])
        }
    })
})

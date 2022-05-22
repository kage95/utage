import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {

    window.messageContainer = document.getElementById('message-container')

    if (messageContainer === null) {
        return
    }

    const data = document.getElementById("data")
    const channel = "RoomChannel"
    const event_id = data.getAttribute("data-event-id")
    const user_id = data.getAttribute("data-user-id")

    const documentElement = document.documentElement
    window.scrollToBottom = () => {
        window.scroll(0, documentElement.scrollHeight)
    }
    scrollToBottom()

    const isSubscribed = (channel, event_id, user_id) => {
        const identifier = `{"channel":"${channel}","event_id":"${event_id}","user_id":"${user_id}"}`
        const subscription = consumer.subscriptions.findAll(identifier)
        return !!subscription.length
    }

    if (!isSubscribed(channel, event_id, user_id)) {
        consumer.subscriptions.create({ channel: "RoomChannel", event_id: event_id, user_id: user_id }, {
            connected() {
            },

            disconnected() {
            },

            received(data) {
                if (data["user_id"] == user_id) {
                    const message = `<div class="my-message d-flex flex-column align-items-start mb-4">${data['message']}</div>`;
                    messageContainer.insertAdjacentHTML('beforeend', message)
                }
                else {
                    const message = `<div class="others-message d-flex flex-column align-items-start mb-4">${data['message']}</div>`;
                    messageContainer.insertAdjacentHTML('beforeend', message)
                }
                scrollToBottom()
            }
        })
    }
})

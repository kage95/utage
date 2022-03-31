import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
    const data = document.getElementById("data")
    const event_id = data.getAttribute("data-event-id")
    const user_id = data.getAttribute("data-user-id")
    const room_id = data.getAttribute("data-room-id")

    window.messageContainer = document.getElementById('message-container')

    if (messageContainer === null) {
        return
    }
    const documentElement = document.documentElement
    window.scrollToBottom = () => {
        window.scroll(0, documentElement.scrollHeight)
    }
    scrollToBottom()

    consumer.subscriptions.create({channel: "RoomChannel", event_id: event_id, user_id: user_id}, {
        connected() {
        },

        disconnected() {
        },

        received(data) {
            if (data["user_id"] == user_id){
                const message = `<div class="my-message d-flex flex-column align-items-start mb-4">${data['message']}</div>`;
                messageContainer.insertAdjacentHTML('beforeend', message)
            }
             else{
                const message = `<div class="others-message d-flex flex-column align-items-start mb-4">${data['message']}</div>`;
                messageContainer.insertAdjacentHTML('beforeend', message)
            }
            scrollToBottom()
        }
    })
})

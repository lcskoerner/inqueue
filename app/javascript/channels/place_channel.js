import consumer from "./consumer";

const initPlaceCable = () => {
  let infoContainer = document.getElementById('info-container');
  if (infoContainer) {
    const id = infoContainer.dataset.placeId;

    consumer.subscriptions.create({ channel: "PlaceChannel", id: id }, {
      received(data) {
        infoContainer.innerHTML = data;
      },
    });
  }
}

export { initPlaceCable };

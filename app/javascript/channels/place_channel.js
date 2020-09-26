import consumer from "./consumer";

const initPlaceCable = () => {
  let infoContainers = document.querySelectorAll('.info-container');
  infoContainers.forEach((infoContainer) => {
    if (infoContainer) {
      const id = infoContainer.dataset.placeId;

      consumer.subscriptions.create({ channel: "PlaceChannel", id: id }, {
        received(data) {
          infoContainer.innerHTML = data;
        },
      });
    }
  });
}

export { initPlaceCable };

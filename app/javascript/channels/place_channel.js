import consumer from "./consumer";

const initPlaceCable = () => {
  //let infoContainer = document.getElementById('info-container');
  let infoContainers = document.querySelectorAll('.info-container');
  infoContainers.forEach((infoContainer) => {
    if (infoContainer) {
      const id = infoContainer.dataset.placeId;

      consumer.subscriptions.create({ channel: "PlaceChannel", id: id }, {
        received(data) {
          console.log(data);
          infoContainer.innerHTML = data;
        },
      });
    }
  });
}

export { initPlaceCable };

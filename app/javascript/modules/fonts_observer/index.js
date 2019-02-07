import FontFaceObserver from "fontfaceobserver";

const Lato = new FontFaceObserver("Lato");
Lato.load()
  .then(() => {
    document.body.classList.add("Lato-loaded");
  })
  .catch(err => {
    document.body.classList.add("Lato-failed");
  });

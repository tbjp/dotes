import { Controller } from '@hotwired/stimulus';
import Swiper from 'swiper';

// Connects to data-controller="swiper"
export default class extends Controller {
  static targets = ['prevBtn', 'nextBtn'];

  connect() {
    this.swiper = new Swiper(this.element, {
      loop: false,
      initialSlide: 1,
    });
  }

  prev() {
    this.swiper.slidePrev();
  }

  next() {
    this.swiper.slideNext();
  }
}

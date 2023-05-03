import { Controller } from "@hotwired/stimulus";

import ExifReader from "exifreader";

export default class extends Controller {
    static targets = ["file", "capturedAt", "latitude", "longitude"];

    connect() {
        const fileField = this.fileTarget;
        console.log(fileField);

        const capturedAtField = this.capturedAtTarget;
        console.log(capturedAtField)
    }

    async changed() {
        const file = this.fileTarget.files[0];
        const tags = await ExifReader.load(file);
        console.log(tags);

        const exifImageDate = tags['DateTimeOriginal'].description;
        this.capturedAtTarget.value = this.#dateFormat(exifImageDate);

        this.latitudeTarget.value = tags['GPSLatitude'].description;
        this.longitudeTarget.value = tags['GPSLongitude'].description;
    }

    #dateFormat(input) {
        const [year, month, day, hour, min, sec] = input.split(/[\: ]/);
        return `${year}-${month}-${day}T${hour}:${min}:${sec}`;
    }
}



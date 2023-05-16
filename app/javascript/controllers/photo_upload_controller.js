import { Controller } from "@hotwired/stimulus";

import ExifReader from "exifreader";

export default class extends Controller {
    static targets = ["file", "capturedAt", "latitude", "longitude"];

    async changed() {
        const file = this.fileTarget.files[0];
        const tags = await ExifReader.load(file, { expanded: true });

        const exifImageDate = tags.exif["DateTimeOriginal"].description;
        this.capturedAtTarget.value = this.#dateFormat(exifImageDate);

        if (Object.hasOwn(tags, "gps")) {
            this.latitudeTarget.value = tags.gps.Latitude;
            this.longitudeTarget.value = tags.gps.Longitude;
        } else {
            console.debug("No GPS data in photo.")
        }
    }

    #dateFormat(input) {
        const [year, month, day, hour, min, sec] = input.split(/[\: ]/);
        return `${year}-${month}-${day}T${hour}:${min}:${sec}`;
    }
}



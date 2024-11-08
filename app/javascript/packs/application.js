import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "bootstrap";
import "@popperjs/core";
import "bootstrap/dist/css/bootstrap.min.css";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

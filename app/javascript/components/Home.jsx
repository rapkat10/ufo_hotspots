import React from "react";
import { Link } from "react-router-dom";

export default () => (
  <div className="d-flex flex-column align-items-center justify-content-center mt-2">
    <h1 className="">UFO Sightings</h1>
    <Link to="/ufo_hotspots" className="btn btn-link mt-5">UFO Hotspots</Link>
    <Link to="/ufo_sightings" className="btn btn-link mt-5">UFO Sightings</Link>
  </div>
);
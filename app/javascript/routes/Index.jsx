import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Home from "../components/Home";
import UfoHotspots from "../components/Ufo_Hotspots";
import UfoSightings from "../components/Ufo_Sightings";

export default (
  <Router>
    <Switch>
      <Route path="/" exact component={Home} />
      <Route path="/ufo_hotspots" exact component={UfoHotspots} />
      <Route path="/ufo_sightings" exact component={UfoSightings} />
    </Switch>
  </Router>
);
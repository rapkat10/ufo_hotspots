import React from "react";
import { Link } from "react-router-dom";

class Ufo_Sightings extends React.Component {
  constructor(props) {
    super(props);
    this.state = { ufo_sightings_within_range: {} };
  }

  componentDidMount() {
    fetch("/api/v01/ufo_sightings")
      .then(response => {
        if (response.ok) { return response.json(); }
      })
      .then(response => this.setState({ ufo_sightings_within_range: response.response }));
  }

  render() {
    const { ufo_sightings_within_range } = this.state;
    if (ufo_sightings_within_range.length === 0) { return null; }
    return (
      <div className="d-flex flex-column justify-content-center m-3">
        <Link to="/" className="btn btn-link">Home</Link>
        {JSON.stringify(ufo_sightings_within_range)}
      </div>
    );
  }
}
export default Ufo_Sightings;
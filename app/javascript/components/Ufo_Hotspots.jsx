import React from "react";
import { Link } from "react-router-dom";

class UfoHotspots extends React.Component {
  constructor(props) {
    super(props);
    this.state = { ufoHotspots: [] };
  }

  componentDidMount() {
    fetch("/api/v01/ufo_hotspots")
      .then(response => {
        if (response.ok) { return response.json(); }
      })
      .then(response => this.setState({ ufoHotspots: response.response }));
  }

  render() {
    const { ufoHotspots } = this.state;
    if (ufoHotspots.length === 0) { return null; }
    return (
      <div className="d-flex flex-column justify-content-center m-3">
        <Link to="/" className="btn btn-link">Home</Link>
        {ufoHotspots.map((ufo_hotspot) => (<div className="d-flex justify-content-center">{ufo_hotspot.name}</div>))}
      </div>
    );
  }
}
export default UfoHotspots;
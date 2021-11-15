import React, { Component } from "react";
import { App } from "./App";
import { Hello } from "./components/Hello";

export interface MainProps {
  app: App;
}

export class Main extends Component<MainProps, {}> {
  constructor(props: MainProps) {
    super(props);
  }

  public render(): JSX.Element {
    return (
      <>
        <Hello message="Bazel React SWC Example">
          <div className="features">
            <div>SCSS + SWC + React</div>
          </div>
        </Hello>
      </>
    );
  }
}

import * as React from "react";
import { JSXChildren } from "../../util";
import { Row, Col } from "../../ui/index";

interface StepContentProps {
  children?: JSXChildren;
  className: string;
}

export function StepContent(props: StepContentProps) {
  const { className } = props;
  return <Row>
    <Col sm={12}>
      <div className={`step-content ${className}`}>
        {props.children}
      </div>
    </Col>
  </Row>;
}

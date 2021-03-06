import { Page } from "../page";
import { mount } from "enzyme";

describe("<Page />", () => {
  it("renders text", () => {
    const result = mount(Page({ children: "nice" }));
    expect(result.html()).toContain("nice");
  });
  it("gets correct className", () => {
    const result = mount(Page({ className: "some-class" }));
    expect(result.find("div").hasClass("some-class")).toBeTruthy();
    expect(result.find("div").hasClass("all-content-wrapper")).toBeTruthy();
  });
});

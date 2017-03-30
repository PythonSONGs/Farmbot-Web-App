require 'spec_helper'

describe Api::ToolSlotsController do
  include Devise::Test::ControllerHelpers

  sequence_fixture = <<~HEREDOC
    [{ "kind":"move_absolute",
       "args":{
           "location":{ "kind":"tool", "args":{ "tool_id": --- } },
           "offset":{ "kind":"coordinate", "args":{ "x":0, "y":0, "z":0 } },
           "speed":800}}]
  HEREDOC

  describe '#destroy' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:tool_bay) { FactoryGirl.create(:tool_bay, device: user.device) }
    let!(:tool) { FactoryGirl.create(:tool, device: user.device) }
    let!(:tool_slot) { FactoryGirl.create(:tool_slot,
                                          tool_bay: tool_bay,
                                          tool: tool) }
    let!(:sequence) { Sequences::Create.run!({
                        device: user.device,
                        name: "TOOL SLOT",
                        body: JSON
                              .parse(sequence_fixture.gsub("---", tool.id.to_s))
                      }) }

    it 'removes a tool slot' do
      sign_in user
      payload = { id: tool_slot.id }
      before = ToolSlot.count
      delete :destroy, params: payload
      expect(response.status).to eq(200)
      after = ToolSlot.count
      expect(response.status).to eq(200)
      expect(after).to be < before
    end

    it 'disallows deletion of slots in use by sequeunces' do
      pending "This test is done, but the implementation has yet to be "\
              "written. Stepping off this task to renew SSL certs. -RC."
      sign_in user
      payload = { id: tool_slot.id }
      before = ToolSlot.count
      delete :destroy, params: payload
      expect(response.status).to eq(200)
      after = ToolSlot.count
      expect(response.status).to eq(422)
      expect(after).to eq(before)
      binding.pry
    end
  end
end

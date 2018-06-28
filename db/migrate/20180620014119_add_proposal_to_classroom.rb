class AddProposalToClassroom < ActiveRecord::Migration[5.1]
  def change
  	add_reference :classrooms, :proposal, foreign_key: true
  end
end

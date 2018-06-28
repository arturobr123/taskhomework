json.extract! proposal, :id, :admin_id, :homework_id, :cost, :notes, :status, :created_at, :updated_at
json.url proposal_url(proposal, format: :json)

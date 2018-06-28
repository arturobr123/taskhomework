class Classroom < ApplicationRecord
  belongs_to :homework
  belongs_to :user
  belongs_to :admin
  belongs_to :proposal

  has_many :archive_classrooms, dependent: :destroy


  #incluye el concern Notificable
	#include NotificableWorkers
  #a quien enviará la notificación
  def admin_ids
  	return self.admin.id
  end


  #solo para verificar que es un salon
  def iam_classroom
    return true
  end

end

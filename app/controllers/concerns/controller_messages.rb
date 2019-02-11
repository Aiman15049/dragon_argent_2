module ControllerMessages
  def record_destroyed
    'The record was deleted.'
  end

  def record_not_destroyed
    'The record could not be deleted. Go figure.'
  end

  def record_not_found
    'The record was not found. Please check for errors.'
  end

  def record_not_saved
    'The record was not saved. Please check for errors.'
  end

  def record_not_updated
    'The record was not updated. Please check for errors.'
  end

  def record_saved
    'The record was successfully saved'
  end
end

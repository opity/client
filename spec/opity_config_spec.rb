require 'spec_helper'

describe Opity do
  context :options do
    it :load do
      expect(Opity.config).not_to be nil
    end

    context :environments do
      it :list do
        expect(Opity.environments.count).to be > 0
      end

      it :resources do
        e = Opity.environments.first
        expect(e.resources.count).to be > 0
      end
    end
  end
end
class GendersEnum < ActiveRecord::Base
    enum genders: {
        male: 0,
        female: 1,
        homo: 2,
        undefined: 3
    }
end
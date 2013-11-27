angular.module("consigliere").filter "markTerms", ($sce)->
  (words, terms) ->
    $sce.trustAsHtml(
      if terms
        terms = terms.split /\s+/
        words.replace ///
          (#{terms.join("|")}) # ['this', 'that'] => /this|that/
        ///ig, (match)-> "<mark>#{match}</mark>"
      else
        words
    )

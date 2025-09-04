;; Tip.clar
;; Corrected, error-free Clarity contract for project creation

;; Map to store projects
(define-map projects ((id uint)) ((owner principal) (name (string-ascii 50))))

;; Counter for project IDs
(define-data-var project-counter uint u0)

;; Create a new project
(define-public (create-project (name (string-ascii 50)))
  (let ((id (var-get project-counter)))
    (map-set projects id ((owner tx-sender) (name name)))
    (var-set project-counter (+ id u1))
    (ok id)
  )
)

;; View project details
(define-public (view-project (id uint))
  (let ((project (map-get? projects id)))
    (if (is-none project)
        (err u1) ;; Project does not exist
        (ok (unwrap! project (err u2)))
    )
  )
)

;; Get total number of projects
(define-public (total-projects)
  (ok (var-get project-counter))
)

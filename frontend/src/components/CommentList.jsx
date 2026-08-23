import StarRating from './StarRating'
import { formatDate, initials } from '../utils/format'

export default function CommentList({ comments }) {
  if (!comments.length) {
    return (
      <div className="text-muted small border rounded-3 p-3" style={{ borderColor: 'var(--line)' }}>
        Todavía no hay comentarios para este dispositivo. Sé la primera persona en opinar.
      </div>
    )
  }

  return (
    <div className="d-flex flex-column gap-2">
      {comments.map((c) => (
        <div className="comment-card" key={c.id}>
          <div className="d-flex justify-content-between align-items-start gap-2">
            <div className="d-flex align-items-center gap-2">
              <span className="comment-avatar">{initials(c.author)}</span>
              <div>
                <div className="fw-semibold small">{c.author}</div>
                <div className="text-muted" style={{ fontSize: '0.75rem' }}>
                  {formatDate(c.date)}
                </div>
              </div>
            </div>
            <StarRating value={c.rating} />
          </div>
          <p className="mb-0 mt-2 small">{c.content}</p>
        </div>
      ))}
    </div>
  )
}

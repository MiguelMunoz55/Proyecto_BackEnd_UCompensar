import { useState } from 'react'
import StarRating from './StarRating'

export default function CommentForm({ onSubmit }) {
  const [author, setAuthor] = useState('')
  const [rating, setRating] = useState(0)
  const [content, setContent] = useState('')
  const [error, setError] = useState('')

  function handleSubmit(e) {
    e.preventDefault()
    if (!author.trim() || !content.trim() || rating === 0) {
      setError('Completa tu nombre, una calificación y tu opinión antes de publicar.')
      return
    }
    setError('')
    onSubmit({
      author: author.trim(),
      rating,
      content: content.trim(),
      date: new Date().toISOString().slice(0, 10),
    })
    setAuthor('')
    setRating(0)
    setContent('')
  }

  return (
    <form className="comment-card" onSubmit={handleSubmit}>
      <div className="filter-title mb-2">Deja tu opinión</div>

      <div className="row g-2">
        <div className="col-sm-6">
          <label className="form-label small mb-1">Tu nombre</label>
          <input
            className="form-control form-control-sm"
            value={author}
            onChange={(e) => setAuthor(e.target.value)}
            placeholder="Ej. Sofía Ramírez"
          />
        </div>
        <div className="col-sm-6">
          <label className="form-label small mb-1 d-block">Calificación</label>
          <StarRating value={rating} onChange={setRating} />
        </div>
      </div>

      <div className="mt-2">
        <label className="form-label small mb-1">Tu opinión</label>
        <textarea
          className="form-control form-control-sm"
          rows="3"
          value={content}
          onChange={(e) => setContent(e.target.value)}
          placeholder="Cuéntanos tu experiencia con este dispositivo…"
        />
      </div>

      {error && <div className="text-danger small mt-2">{error}</div>}

      <button type="submit" className="btn btn-accent btn-sm mt-3">
        Publicar comentario
      </button>
    </form>
  )
}

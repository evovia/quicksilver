/**
 * useFloatingUI stimulus mixin
 *
 * Adds FloatingUI positioning capabilities to a Stimulus controller
 * Requires the controller to have:
 * - referenceElement (element to position relative to)
 * - floatingElement (element to be positioned)
 * - positioningOptions (FloatingUI options object)
 */

import {
  computePosition,
  flip,
  shift,
  offset,
  autoUpdate
} from "@floating-ui/dom"

export const useFloatingUI = (controller, referenceElement, floatingElement, positioningOptions = {}, options = {}) => {
  if (!referenceElement) {
    throw new Error('useFloatingUI requires a referenceElement parameter')
  }
  if (!floatingElement) {
    throw new Error('useFloatingUI requires a floatingElement parameter')
  }

  const {
    autoUpdateOnShow = true
  } = options

  let finalPositioningOptions
  if (Object.keys(positioningOptions).length === 0) {
    finalPositioningOptions = {
      placement: 'bottom-start',
      middleware: [
        offset(4),
        flip(),
        shift({ padding: 8 })
      ]
    }
  } else {
    finalPositioningOptions = positioningOptions
  }

  const originalDisconnect = controller.disconnect?.bind(controller) || (() => { })

  const updatePosition = () => {
    computePosition(
      referenceElement,
      floatingElement,
      finalPositioningOptions
    ).then(({ x, y, placement, middlewareData }) => {
      Object.assign(floatingElement.style, {
        left: `${x}px`,
        top: `${y}px`,
      })

      if (controller.onPositionUpdate) {
        controller.onPositionUpdate({ x, y, placement, middlewareData })
      }
    })
  }

  const setupAutoUpdate = () => {
    if (!autoUpdateOnShow) return

    if (!controller.floatingUICleanup) {
      controller.floatingUICleanup = autoUpdate(
        referenceElement,
        floatingElement,
        updatePosition
      )
    }
  }

  const cleanupAutoUpdate = () => {
    if (controller.floatingUICleanup) {
      controller.floatingUICleanup()
      controller.floatingUICleanup = null
    }
  }

  const methodsToAdd = {
    updatePosition,
    setupAutoUpdate,
    cleanupAutoUpdate,

    disconnect() {
      cleanupAutoUpdate()
      originalDisconnect()
    },

    showWithPositioning() {
      setupAutoUpdate()
      updatePosition()
    },

    hideWithPositioning() {
      cleanupAutoUpdate()
    }
  }

  Object.assign(controller, methodsToAdd)
}
